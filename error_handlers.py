from startup import app
from schemas import error_response


@app.errorhandler(400)
def handle_400(error):
    print(error)
    return error_response(error.description), 400


@app.errorhandler(404)
def handle_404(error):
    if "URL" in error.description:
        return error_response("not found"), 404
    return error_response(error.description), 404


@app.errorhandler(401)
def handle_401(error):
    return error_response("invalid credentials"), 401


@app.errorhandler(500)
def handle_500(error):
    return error_response("internal server error"), 500