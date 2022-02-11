from flask import request, make_response, render_template, redirect
from startup import app, db
from models import User, Session, Todo
from flask import abort
import utils
from time import time
from schemas import success_response
import config


@app.route("/", methods=["GET"])
def landing_page():
    return render_template("index.html")


@app.route("/register", methods=["POST"])
def register():
    email = request.form.get("email")
    username = request.form.get("username")
    password = request.form.get("password")
    first_name = request.form.get("first_name")
    last_name = request.form.get("last_name")

    existing_user: User = User.query.filter_by(email=email).first()
    if existing_user is not None:
        abort(400, "email already in use")

    salt = utils.random_token()
    password_hash = utils.salted_hash(password, salt)

    user = User(
        register_date=int(time()),
        email=email,
        username=username,
        password_hash=password_hash,
        password_salt=salt,
        first_name=first_name,
        last_name=last_name,
    )

    db.session.add(user)
    db.session.flush()

    token = utils.random_token()

    token_hash = utils.salted_hash(token, config.SESSION_KEY_SALT)
    session = Session(user_id=user.id, token_hash=token_hash)

    response = make_response(render_template("home.html"))
    cookie_max_age = None
    response.set_cookie(
        key=config.SESSION_COOKIE_KEY,
        value=token,
        max_age=cookie_max_age,
        secure=False,
    )

    db.session.add(session)
    db.session.commit()

    return response


@app.route("/login", methods=["POST"])
def login():
    email_or_username = request.form.get("email")
    password = request.form.get("password")

    user: User = User.query.filter(
        (User.email == email_or_username) | (User.username == email_or_username)
    ).first()
    if user is None:
        abort(401)

    if not utils.check_password(password, user):
        abort(401)

    token = utils.random_token()

    token_hash = utils.salted_hash(token, config.SESSION_KEY_SALT)
    session = Session(user_id=user.id, token_hash=token_hash)
    db.session.add(session)
    db.session.commit()

    response = make_response(
        render_template("home.html", full_name=user.first_name + " " + user.last_name)
    )
    cookie_max_age = None
    response.set_cookie(
        key=config.SESSION_COOKIE_KEY,
        value=token,
        max_age=cookie_max_age,
        secure=False,
    )

    return response


@app.route("/password-reset-request", methods=["POST"])
def password_reset_request():
    email = request.form.get("email")

    user: User = User.query.filter_by(email=email).first()
    if user is None:
        abort(401)

    token = utils.random_token()
    user.password_reset_token = token
    db.session.commit()

    # TODO: send user an email containing the authorized link (with the generated token)
    # like so: http://localhost:5000/password-reset/**Token goes here**
    print(f"http://localhost:5000/password-reset/{token}")

    return render_template("index.html")


@app.route("/password-reset/<string:token>", methods=["GET"])
def password_reset(token: str):

    user: User = User.query.filter_by(password_reset_token=token).first()
    if user is None:
        abort(401)

    new_password = utils.random_password()

    # TODO: send new password in email
    print("New password:", new_password)

    new_password_hash = utils.salted_hash(new_password, user.password_salt)

    user.password_hash = new_password_hash
    db.session.commit()

    return render_template("password_reset_success.html")


@app.route("/logout", methods=["GET"])
def logout():
    session, user = utils.auth_session()

    db.session.delete(session)
    db.session.commit()

    response = make_response(success_response("logged out"))
    response.delete_cookie(key=config.SESSION_COOKIE_KEY)

    return render_template("index.html")


@app.route("/todo", methods=["POST"])
def create_todo():
    session, user = utils.auth_session()
    todo_text = request.form.get("todo")
    category_id = request.form.get("category_id")

    todo_element = Todo(
        user_id=user.id,
        creation_date=int(time()),
        category_id=category_id,
        todo=todo_text,
        done=False,
    )

    db.session.add(todo_element)
    db.session.commit()

    return render_template("home.html")


@app.route("/todo", methods=["GET"])
def get_todos():
    session, user = utils.auth_session()

    todos: "list[Todo]" = Todo.query.filter_by(user_id=user.id).all()
    return success_response(
        [
            {
                "id": t.id,
                "todo": t.todo,
                "done": t.done,
                "creation_date": t.creation_date,
                "category_id": t.category_id,
                "category": t.category.category,
            }
            for t in todos
        ]
    )
