# Fejlesztői szerver beállítása

- `Windowson`
    - `Importáld a vizsgaremek.sql file-t`
    - `Cloneozd ezt a repot`
    - `A config.py-ben szedd ki a kommentet a DB_URI = 'mysql://root@localhost/project' elől, és->`
    - `kommenteld ki az alatta lévő DB_URI elérési utat`
    - `Terminálba: virtualenv venv`
    - `Futtassa a powershelt adminisztrátorként, majd->`
    - `set-executionpolicy remotesigned, vagy->` 
    - `Set-ExecutionPolicy Unrestricted -Scop CurrentUser`
    - `Szükséges csomagok telepítése`
        - `Szükséges csomagok telepítése`
        - `venv/Scripts/activate`
        - `pip install -r requirements.txt`
    - `Szerver futtatása:`
        - `flask run / flask run --reload`
    
- `Linuxon`
    - `Importáld a vizsgaremek.sql file-t`
    - `Cloneozd ezt a repot`
    - `A config.py-ben szedd ki a kommentet a DB_URI = 'mysql://root@localhost/project' elől, és->`
    - `kommenteld ki az alatta lévő DB_URI elérési utat`
    - `Terminálba: virtualenv venv`
        - `Szükséges csomagok telepítése`
        - `Szükséges csomagok telepítése`
        - `source venv/bin/activate`
        - `pip install -r requirements.txt`
    - `Szerver futtatása:`
        - `flask run / flask run --reload`
    




