module Api
    class TestsController < ApplicationController
        def index
            render json: { data: 'Hello World!' }
        end
    end
end
