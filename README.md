I assume You already have python installed and are using windows. The first step will be to install poetry and create a new project with it. We'll be using poetry, even though we won't be publishing anything, because it sometimes helps with avoiding corporate policies regarding repositories like npm etc.

```python
python -m venv .venv
.venv/scripts/Activate.ps1
python -m pip install --upgrade pip setuptools
python -m pip install poetry
```

Now let's initialize our project and go through setup as prompted

`poetry init`

Then when asked for main dependencies add robotframework and robotframework-browser in latest versions. We can also add pyyaml to be able to handle .yaml variable files

Now lets install all dependencies, we're not going to publish this so we'll use the -no-root option
`poetry install --no-root`

Then we need to initialize our browser environment

`rfbrowser init`

And now we should be ready to start our testing, but just to make things easier let's also create a robot arguments file and add the outputdir and loglevel options.
