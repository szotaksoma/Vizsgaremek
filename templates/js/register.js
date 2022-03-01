function jelszoErosseg(){
    const jelszo = document.getElementById("jelszo-input").value
    let szelesseg = jelszo.length
    if(jelszo.length < 5){
        document.getElementById("jelszo-erosseg").style.width = szelesseg*1.5 + "rem"
        document.getElementById("jelszo-erosseg").style.backgroundColor = "red"
    }
    else if(jelszo.length >= 5 && jelszo.length < 12){
        document.getElementById("jelszo-erosseg").style.width = szelesseg*1.5 + "rem"
        document.getElementById("jelszo-erosseg").style.backgroundColor = "orange"
    }
    else if(jelszo.length >= 12 && jelszo.length < 15){
        document.getElementById("jelszo-erosseg").style.width = szelesseg*1.5 + "rem"
        document.getElementById("jelszo-erosseg").style.backgroundColor = "green"
    }
}


const togglePassword = document.querySelector('#togglePassword');
const password = document.querySelector('#jelszo-input');

togglePassword.addEventListener('click', function (e) {
  // toggle the type attribute
  const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
  password.setAttribute('type', type);
  // toggle the eye slash icon
  this.classList.toggle('fa-eye-slash');
});

// INPUT VALIDÁCIÓ

function validate(){
    const vezeteknev = document.getElementById("vezeteknev-input").value
    const keresztnev = document.getElementById("keresztnev-input").value
    const email = document.getElementById("email-input").value
    const felhasznalo = document.getElementById("felhasznalo-input").value
    const jelszo = document.getElementById("jelszo-input").value
    const jelszo_megegyszer = document.getElementById("jelszo-megint-input").value
    const szuletes = document.getElementById("szuletes-input").value 
}