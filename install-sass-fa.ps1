write-host Installing Sass and FontAwesome -foregroundcolor green

if (-not (Test-Path package.json -PathType Leaf)) {
    npm init -y | out-null
}
npm install --save-dev @fortawesome/fontawesome-pro sass @rogerpence/edit-package-json

if (-not(Test-Path -Path ".\dist\assets\webfonts")) {
    new-item .\dist\assets\webfonts -itemtype directory | out-null
}

if (-not(Test-Path -Path ".\dist\assets\css")) {
    new-item .\dist\assets\css -itemtype directory | out-null
}

if (-not(Test-Path -Path ".\scss\fa-scss")) {
    new-item .\scss\fa-scss -itemtype directory | out-null
}

if (-not(Test-Path -Path ".\scss\components")) {
    new-item .\scss\components -itemtype directory | out-null
}

# Copy FA scss folder (from node_modules) into .\scss\fa-scss.
copy-item -path node_modules\@fortawesome\fontawesome-pro\scss\* -destination .\scss\fa-scss\
copy-item -path node_modules\@fortawesome\fontawesome-pro\css\all.css -destination .\dist\assets\css\all.css
copy-item -path node_modules\@fortawesome\fontawesome-pro\js\all.js -destination .\dist\assets\css\all.js

# Copy Font Awesome's Web fonts.
copy-item -path node_modules\@fortawesome\fontawesome-pro\webfonts\* -destination .\dist\assets\webfonts\

# Add Sass build scripts to package.json.
$scriptValue = "npx+sass+scss/global.scss+dist/assets/css/global.css+--watch"
npx editPackageJson -k "sass:dev" -v $scriptValue --out-null
$scriptValue = "npx+sass+scss/global.scss+dist/assets/css/global.css+--style=compressed"
npx editPackageJson -k "sass:prod" -v $scriptValue --out-null

invoke-webrequest -uri "https://raw.githubusercontent.com/rogerpence/install-sass-font-awesome/main/dist/index.html" -outfile .\dist\index.html
invoke-webrequest -uri "https://raw.githubusercontent.com/rogerpence/install-sass-font-awesome/main/dist/pseudo-before.html" -outfile .\dist\index_pseudo_before.html
invoke-webrequest -uri "https://raw.githubusercontent.com/rogerpence/install-sass-font-awesome/main/scss/components/_icons-pseudo-before.scss" -outfile .\scss\components\_icons-pseudo-before.scss
invoke-webrequest -uri "https://raw.githubusercontent.com/rogerpence/install-sass-font-awesome/main/scss/global.scss" -outfile .\scss\global.scss
invoke-webrequest -uri "https://raw.githubusercontent.com/rogerpence/install-sass-font-awesome/main/.gitignore" -outfile .\.gitignore