# module Knockout
#   module Observable
#     def to_s
#       `#{self.call} + ''`
#     end
#
#     def +(value)
#       self.call.+(value)
#     end
#
#     def -(value)
#       self.call.-(value)
#     end
#   end
# end