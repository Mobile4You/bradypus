Amber::Server.configure do |app|
  pipeline :web do
    # Plug is the method to use connect a pipe (middleware)
    # A plug accepts an instance of HTTP::Handler
    plug Amber::Pipe::PoweredByAmber.new
    # plug Amber::Pipe::ClientIp.new(["X-Forwarded-For"])
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Logger.new
    plug Amber::Pipe::Session.new
    plug Amber::Pipe::Flash.new
    plug Amber::Pipe::CSRF.new unless Amber.env.development?
    # Reload clients browsers (development only)
    plug Amber::Pipe::Reload.new if Amber.env.development?
  end

  # All static content will run these transformations
  pipeline :static do
    plug Amber::Pipe::PoweredByAmber.new
    # plug Amber::Pipe::ClientIp.new(["X-Forwarded-For"])
    plug Amber::Pipe::Error.new
    plug Amber::Pipe::Static.new("./public")
  end

  routes :static do
    # Each route is defined as follow
    # verb resource : String, controller : Symbol, action : Symbol
    get "/*", Amber::Controller::Static, :index
  end

  routes :web do
    # Products
    resources "/products", ProductController
    
    # Jobs
    get "/products/:id/jobs", JobController, :index
    post "/products/:id/jobs", JobController, :create
    get "/products/:id/jobs/:jobId", JobController, :show
    get "/products/:id/jobs/:jobId/edit", JobController, :edit
    get "/products/:id/jobs/new", JobController, :new
    patch "/products/:id/jobs/:jobId", JobController, :update
    delete "/products/:id/jobs/:jobId", JobController, :destroy

    # Versions
    get "/products/:id/versions", VersionController, :index
    post "/products/:id/versions", VersionController, :create

    get "/", HomeController, :index
  end
end
