from crypt import methods
from ctypes import util
from urllib import response
from flask import request, make_response, render_template
from startup import app, db
from models import User, Session, Todo
from flask import abort
import utils
import requests
from time import time
from schemas import success_response, todo_shema, user_schema
import config




@app.route("/api/register", methods=["POST"])
def json_register():

    """
    Új felhasználó regisztrálása
    """


    email, username, password, first_name, last_name = utils.validate_json(
        "email", "username", "password", "firstName", "lastName"
    )

    # Csekk hogy használatban van-e az e-mail
    existing_user: User = User.query.filter_by(email=email).first()
    if existing_user is not None:
        abort(400, "email already in use")

    # Csekk hogy használatban van-e a username
    existing_user = User.query.filter_by(username=username).first()
    if existing_user is not None:
        abort(400, "username already in use")

    salt = utils.random_token()
    password_hash = utils.salted_hash(password, salt)

    email_verification_token = utils.random_token()
    print(f"http://localhost:5000/api/verify-email{email_verification_token}")

    user = User(
        register_date=int(time()),
        email=email,
        username=username,
        password_hash=password_hash,
        password_salt=salt,
        first_name=first_name,
        last_name=last_name,
        email_verification_token=email_verification_token,
    )

    db.session.add(user)
    db.session.commit()

    # TODO: e-mail-t küldeni a felhasználónak megerősítő URL-el, generált tokennel
    # ...

    return success_response("successfully registered")


@app.route("/api/verify-email", methods=["GET"])
def json_verify_email():

    """
    Újonnan regisztrált email-cím megerősítése
    """

    email_verification_token = request.args.get("token")
    user: User = User.query.filter_by(
        email_verification_token=email_verification_token
    ).first()
    if user is None:
        abort(401)

    user.email_verification_token = None
    db.session.commit()

    token = utils.random_token()

    token_hash = utils.salted_hash(token, config.SESSION_KEY_SALT)
    session = Session(user_id=user.id, token_hash=token_hash)
    db.session.add(session)
    db.session.commit()

    response = make_response(
        success_response("email verified, logged in as " + user.email)
    )
    cookie_max_age = None
    response.set_cookie(
        key=config.SESSION_COOKIE_KEY,
        value=token,
        max_age=cookie_max_age,
        secure=False,
    )

    return response


@app.route("/api/login", methods=["POST"])
def json_login():

    """
    Felhasználó bejelentkeztetése
    """

    email_or_username, password = utils.validate_json("email_or_username", "password")

    user: User = User.query.filter(
        (User.email == email_or_username) | (User.username == email_or_username)
    ).first()
    if user is None:
        abort(401)

    if user.email_verification_token is not None:
        abort(400, "email not verified")

    if not utils.check_password(password, user):
        abort(401)

    token = utils.random_token()

    token_hash = utils.salted_hash(token, config.SESSION_KEY_SALT)
    session = Session(user_id=user.id, token_hash=token_hash)
    db.session.add(session)
    db.session.commit()

    response = make_response(success_response("logged in successfully"))
    cookie_max_age = None
    response.set_cookie(
        key=config.SESSION_COOKIE_KEY,
        value=token,
        max_age=cookie_max_age,
        secure=False,
    )

    return response


@app.route("/api/password-reset-request", methods=["POST"])
def json_password_reset_request():

    """
    Új jelszó kérés elfelejtett jelszó esetén
    """

    email, = utils.validate_json("email")

    user: User = User.query.filter_by(email = email).first()

     
    token = utils.random_token()
    user.password_reset_token = token
    db.session.commit()
     

    # TODO: E-mailt-t küldeni a felhasználónak, ami tartalmazza az 'Auth' linket (a generált tokennel)
    # Például: http://localhost:5000/api/password-reset/**Ide jön a token**
    print(f"http://localhost:5000/api/password-reset/{token}")

    return success_response("password reset sent to: " + user.email)



@app.route("/api/password-reset/<string:token>", methods=["GET"])
def json_password_reset(token: str):

    """
    Újonnan generált jelszó kiküldése e-mail-re
    """

    user: User = User.query.filter_by(password_reset_token=token).first()
    if user is None:
        abort(401)

    new_password = utils.random_password()

    # TODO: új jelszót küldeni e-mail-ben
    print("New password:", new_password)

    new_password_hash = utils.salted_hash(new_password, user.password_salt)
 

    user.password_hash = new_password_hash
    db.session.commit()

    return success_response("password reset successfully")


@app.route("/api/logout", methods=["GET"])
def json_logout():

    """
    Kijelentkezteti a Felhasználót
    """

    session, user = utils.auth_session()

    db.session.delete(session)
    db.session.commit()

    response = make_response(success_response("logged out"))
    response.delete_cookie(key=config.SESSION_COOKIE_KEY)

    return response


@app.route("/api/todo", methods=["POST"])
def json_create_todo():

    """
    Létrehoz egy TODO-t
    Visszaadja az újonnan létrehozott TODO objektumot
    """

    session, user = utils.auth_session()

    todo_text, category_id = utils.validate_json("todo", "categoryID")

    todo_element = Todo(
        user_id=user.id,
        creation_date=int(time()),
        category_id=category_id,
        todo=todo_text,
        done=False,
    )

    db.session.add(todo_element)
    db.session.commit()

    return success_response(todo_shema(todo_element))


@app.route("/api/todo", methods=["GET"])
def json_get_todos():

    """
    Visszaadja a felhasználó összes TODO objektumát
    """

    session, user = utils.auth_session()
    todos: "list[Todo]" = Todo.query.filter_by(user_id=user.id).all()
    return success_response([todo_shema(t) for t in todos])
    # így is lehet használni: map(todo_shema, todos)



# User adatokkal kapcsolatos endpoint-ok

@app.route("/api/profile-data", methods=["GET"])
def json_profile_data():
    session, user = utils.auth_session()

    user_element = User(
        id = user.id,
        username=user.username,
        email=user.email,
        first_name=user.first_name,
        last_name=user.last_name,
        register_date=user.register_date
    )

    return success_response(user_schema(user_element))



@app.route("/api/change-password", methods=["PATCH"])
def json_change_password():

    """
    Bejelentkezett felhasználó jelszavának módosítása
    """

    session, user = utils.auth_session()
    new_password, = utils.validate_json("newPassword")

    print("New password:", new_password)

    new_password_hash = utils.salted_hash(new_password, user.password_salt)
 
    user.password_hash = new_password_hash
    db.session.commit()

    return success_response("password changed successfully")


@app.route("/api/change-username", methods=["PATCH"])
def json_change_username():

    """
    Bejelentkezett felhasználó felhasználónevének módosítása
    """

    session, user = utils.auth_session()
    new_username, = utils.validate_json("newUsername")

    # Csekk hogy használatban van-e a username
    existing_user = User.query.filter_by(username=new_username).first()
    if existing_user is not None:
        abort(400, "a felhasználónév már foglalt")

    print("New Username:", new_username)

    user.username = new_username
    db.session.commit()

    return success_response("username changed successfully")


@app.route("/api/change-data", methods=["PATCH"])
def json_change_data():

    """
    Bejelentkezett felhasználó adatainak módosítása
    """

    session, user = utils.auth_session()
    new_first_name, new_last_name = utils.validate_json("newFirstName", "newLastName")


    print("New name:", new_first_name + " " + new_last_name)

    user.first_name = new_first_name
    user.last_name = new_last_name
    db.session.commit()

    return success_response("data changed successfully")