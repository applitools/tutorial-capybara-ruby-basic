VERSION=$(gem search -e eyes_capybara | grep eyes_capybara | grep -E -o "[0-9]+.[0-9]+.[0-9]+")
echo "$VERSION"
bundle remove eyes_capybara && bundle add eyes_capybara -v "$VERSION"