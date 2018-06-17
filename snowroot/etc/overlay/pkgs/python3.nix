self: super:

{
  python3 = super.python3.withPackages(ps: with ps; [
    # Dependencies
    ## Bspwm
    ### gmail
    google_api_python_client
    ### weather_icons
    requests
    ### VSCode Python
    autopep8
    pylint
  ]);
}
