# Ziggurat

Ziggurat is a tiny JavaScript library for creating HTML elements
based on data provided by JavaScript.

Ziggurat is divided into modules, each of which follows the UNIX philosophy
of doing one thing, and doing it well:
- `zg-core`: Main module - provides `zg.query` and `zg.deepfind`
- `zg-forms`: Shorthand for form `onsubmit` with form data
- `zg-mirror`: Simple state management solution, prorvides `zg.mirror`
- `zg-stream`: Helper methods for chunked HTTP 

## Usage

Before importing Ziggurat, you must include [`Imperative HTML`](https://www.npmjs.com/package/imperative-html).

You may either use the combined `ziggurat.js` file, or import the modules separately.

In the latter case, remember to always inlude `zg-core` first.
