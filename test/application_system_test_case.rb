require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ] do |options|
    options.binary = "/usr/bin/google-chrome"

    # These flags help Chrome run more reliably in a low-memory container environment
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage") # Most important to prevent tab crashes
    options.add_argument("--disable-gpu")
    options.add_argument("--headless=new")

    # Additional flags to reduce memory usage
    options.add_argument("--disable-software-rasterizer")
    options.add_argument("--disable-extensions")
    options.add_argument("--memory-pressure-off")
    options.add_argument("--remote-debugging-pipe") # Replace port with pipe for more stability

    options.add_argument("--ignore-certificate-errors")
    options.add_argument("--allow-insecure-localhost")
    # Remove HSTS to allow testing without SSL
    options.add_argument("--disable-hsts")
  end

  Capybara.server = :puma, { Silent: true }
end
