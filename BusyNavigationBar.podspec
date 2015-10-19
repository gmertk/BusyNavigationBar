Pod::Spec.new do |s|
  s.name         = "BusyNavigationBar"
  s.version      = "1.0.0"
  s.summary      = "A UINavigationBar extension to show loading effects as in Periscope app"

  s.description  = <<-DESC
                   A UINavigationBar extension to show loading effects as in Periscope app.
                   This extension can insert stripes, bars, or your custom layer above navigation bar's background.
                   DESC

  s.homepage     = "https://github.com/gmertk/BusyNavigationBar"
  # s.screenshots  = "https://dl.dropboxusercontent.com/u/4397140/pod-screenshots/busynavigationbar/blue_stripe.gif", "https://dl.dropboxusercontent.com/u/4397140/pod-screenshots/busynavigationbar/gray_bird.gif"

  s.license      = "MIT"

  s.author             = { "Gunay Mert Karadogan" => "mertkaradogan@gmail.com" }
  s.social_media_url   = "http://twitter.com/gunaymertk"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/gmertk/BusyNavigationBar.git", :tag => s.version.to_s }

  s.source_files = "BusyNavigationBar/BusyNavigationBar/*.swift"

end
