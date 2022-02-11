from models import Todo


def success_response(data):
    return {"result": "ok", "data": data}


def error_response(data):
    return {"result": "error", "data": data}


def todo_shema(todo: Todo):
    return {
        "id": todo.id,
        "user_id": todo.user_id,
        "category_id": todo.category_id,
        "creation_date": todo.creation_date,
        "todo": todo.todo,
        "done": todo.done,
    }
