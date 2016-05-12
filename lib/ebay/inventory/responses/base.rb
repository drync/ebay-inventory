module Ebay # :nodoc:
  module Inventory # :nodoc:
    module Responses # :nodoc:
      class Base
        def errors?
          errors.size > 0
        end

        def success?
          ack.upcase == 'SUCCESS'
        end

        def warning?
          ack.upcase == 'WARNING'
        end

        def failure?
          ack.upcase == 'FAILURE'
        end
      end
    end
  end
end
