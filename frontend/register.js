async function register() {
    const {result, json} = await sendRegisterRequest()
    if(result.status === 200) {
        alert("Sikeres regisztráció!")
        window.location.replace("foobar.html")

    } else if (json["data"] === "email already in use") {
        alert("Ez az email már foglalt.")

    } else {
        alert("Valami elromlott.")
    }
}

async function sendRegisterRequest() {

    const formValues = getFormValues()
    const result = await fetch("http://localhost:5000/api/register", {
        method: "POST",
        credentials: "include",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(formValues)
    })

    const json = await result.json()

    return {result, json}
}

function getFormValues() {
    const email = document.getElementById("reg-form-email").value
    const username = document.getElementById("reg-form-username").value
    const password = document.getElementById("reg-form-password").value
    const lastName = document.getElementById("reg-form-lastName").value
    const firstName = document.getElementById("reg-form-firstName").value
    return {
        email, username, password, lastName, firstName
    }
}