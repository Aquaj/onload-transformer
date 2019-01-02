# Onload Transformer for Sprockets

## What?

It's a small transformer for Sprockets that allows you to make a JS file wait for the document's `DOMContentLoaded` instead of running right when read.

## Why?

Because vendors sometimes provide minified JS that's meant to be copy-pasted at the end of your page, but you don't want to do that because of turbolinks, personal conviction or other, but if you serve it through your asset pipeline you end up running it before your DOM is ready.
Or you can use it to never write a `$(document).ready` again in your life I guess? I'm not the boss of you, use it for whatever you find it useful for.

## How? (does it work)

It just wraps the whole file in a function and then binds it to the `DOMContentLoaded` event (with the proper check beforehand in case the DOM is already loaded).

## How? (do i use it)

- Add the gem to your gemfile.
- Use the extension .onload.js instead of .js for your files.

## What? (can be improved)

Probably a lot of stuff, but at least:
 - [ ] The functions used to wrap the body of the file are in the global namespace. It would be better if they were defined on a transformer-only object.
 - [ ] Make it so it can be used with .js.erb / .js.coffee (maybe ?)
