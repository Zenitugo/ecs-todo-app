from flask import Flask, request, jsonify, render_template

app = Flask(__name__)

# In-memory storage
todos = []
counter = 1

@app.route("/")
def home():
    return render_template("index.html", todos=todos)

@app.route("/health")
def health():
    return "OK", 200

@app.route("/todos", methods=["GET"])
def get_todos():
    return jsonify(todos)

@app.route("/todos", methods=["POST"])
def add_todo():
    global counter
    data = request.get_json()
    todo = {
        "id": counter,
        "task": data["task"],
        "done": False
    }
    todos.append(todo)
    counter += 1
    return jsonify(todo), 201

@app.route("/todos/<int:todo_id>", methods=["PUT"])
def complete_todo(todo_id):
    for todo in todos:
        if todo["id"] == todo_id:
            todo["done"] = True
            return jsonify(todo)
    return jsonify({"error": "Not found"}), 404

@app.route("/todos/<int:todo_id>", methods=["DELETE"])
def delete_todo(todo_id):
    global todos
    todos = [t for t in todos if t["id"] != todo_id]
    return jsonify({"message": "Deleted"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
