# Sentence.io UI

[Sentence.io](http://sentence.io.s3-website.eu-central-1.amazonaws.com/) is a web application
build with [Elm language](https://elm-lang.org/).
For its core functionality, this project uses [Elm Parser ❤️](https://package.elm-lang.org/packages/elm/parser/latest/Parser) and [Elm UI 😍](https://package.elm-lang.org/packages/mdgriffith/elm-ui/1.1.8/)
package️s

## CI/CD

This project uses GitHub actions to build and deploy the UI application to Amazon S3 bucket
1. GitHub action gets triggered on main branch
2. Installs Elm language
3. Installs Node.js
4. Installs local dependencies
5. Builds the project
6. Deploys to S3

---

The project can be found on [Sentence.io](http://sentence.io.s3-website.eu-central-1.amazonaws.com/)
