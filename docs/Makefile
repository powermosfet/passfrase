all: app.js styles.css

app.js: src/getwords.elm src/main.elm src/message.elm src/model.elm src/passphrase.elm src/update.elm src/view.elm
	elm-make src/main.elm --output app.js

styles.css: src/styles/*.elm
	elm-css src/styles/stylesheet.elm


