all: app.js styles.css

app.js: src/*.elm
	elm-make src/main.elm --output app.js

styles.css: src/styles/*.elm
	elm-css src/styles/stylesheet.elm


