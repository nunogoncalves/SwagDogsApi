<h1>Sample application with swagger integration.</h1>

- Master is a simple API without swagger
- Swagger branch contains Swagger integration

---

<h3>How to view the this sample API documentation</h3>
- change to swagger branch
- rake db:create
- rake db:migrate
- rails s
- http://localhost:3000/docs

You can interact with the api (CRUD methods) through the swagger interface.

---

<h3>How to create documentation for your API and have documentation to look like this:</h3>
<img src="https://dl.dropboxusercontent.com/u/2001692/imagesshelf/SwaggerSample/swagger_index.png" alt="">

<img src="https://dl.dropboxusercontent.com/u/2001692/imagesshelf/SwaggerSample/swagger_post.png" alt="">

- Add the swagger-docs to your gemfile
```ruby
gem 'swagger-docs', '0.1.8'
```

- Create an initializer in your application, for example, swagger_docs.rb
```ruby
API = "docs"
Swagger::Docs::Config.register_apis({
  "0.0" => {
    # the extension used for the API
    :api_extension_type => :json,
    # the output location where your .json files are written to
    :api_file_path => "public/#{API}",
    # the URL base path to your API
    :base_path => "http://localhost:3000",
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

- Download swagger-ui from https://github.com/wordnik/swagger-ui
  - Clone to your compute and copy the contents of dist folder to your a application public folder.
  - You probably need to check the index.html path to load it in your broswer afterwards. (in this case we have moved the index.html from swagger-ui folder to docs folder)
    - To follow this app's example here's a snapshot of the structure (swagger branch only)

<img src="https://dl.dropboxusercontent.com/u/2001692/imagesshelf/SwaggerSample/swagger_docs_structure.png" alt="">

  - Make sure you update references for resources in the swagger index.html file
    - In this case:
      &lt;script src='lib/jquery-1.8.0.min.js' type='text/javascript'&gt;&lt;/script&gt;
      to
      &lt;script src='docs/swagger-ui/lib/jquery-1.8.0.min.js' type='text/javascript'&gt;&lt;/script&gt;
  - Also in the index file locate the line

    ```javascript
    window.swaggerUi = new SwaggerUi({
          url: "http://petstore.swagger.wordnik.com/api/api-docs",
          dom_id: "swagger-ui-container",
          ...
    })
    ```
    and replace the url with "api-docs" only.

- Add

  ```ruby
  swagger_controller :your_controller, 'Your Controller'
  ```

- Now you are ready to start building documentation.
  - To document the index action, add the following snippet to your controller

  ```ruby
    swagger_api :index do
      summary "Get the list of all dogs"
      notes "It's possible to filter dogs"

      param :query, :name, :string, :optional, "Filter by dog name"

      response :ok
    end
  ```
- run the rake task

```ruby
  rake swagger:docs
```

- now visit the swagger index.html file page (in this case, /docs/index.html)
http://localhost:3000/docs

You should be able to see a swagger page with the index action documented.
