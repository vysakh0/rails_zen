module MyGem
  class Railtie < Rails::Railtie
    initializer "Include your code in the controller" do
      ActiveSupport.on_load(:action_controller) do
        include MyGem
      end
    end
end
