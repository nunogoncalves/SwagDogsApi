<h1>Sample application with swagger integration.</h1>
---

Master is a simple API without swagger
Swagger branch contains Swagger integration

---

<h3>How to view the api documentation</h3>
- rake db:create
- rake db:migrate
- rails s -p 2012 -> hard coded inside the app set to this port.
- http://localhost:2012/docs

You can interact with the api (CRUD methods) through the swagger interface.

---

<h3>How to create documentation for your API and have documentation to look like this:</h3>
<img src="https://dl.dropboxusercontent.com/u/2001692/imagesshelf/SwaggerSample/swagger_index.png" alt="">

<img src="https://dl.dropboxusercontent.com/u/2001692/imagesshelf/SwaggerSample/swagger_post.png" alt="">


Create an initializer in your application, for example, swagger_docs.rb
```ruby
API = "docs"
Swagger::Docs::Config.register_apis({
  "0.0" => {
    # the extension used for the API
    :api_extension_type => :json,
    # the output location where your .json files are written to
    :api_file_path => "public/#{API}",
    # the URL base path to your API
    :base_path => "http://localhost:2012",
    # if you want to delete all .json files at each generation
    :clean_directory => false,
    # add custom attributes to api-docs
    :attributes => {
      :info => {
        "title" => "Swagger Dogs Sample App",
        "description" => "This is a sample description.",
        "termsOfServiceUrl" => "http://helloreverb.com/terms/",
        "contact" => "apiteam@wordnik.com",
        "license" => "Apache 2.0",
        "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
      }
    }
  }
})

class Swagger::Docs::Config
  def self.transform_path(path)
    "#{API}/#{path}"
  end
end
```

