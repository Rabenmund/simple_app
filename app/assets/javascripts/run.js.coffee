# $ ->
#   $(document).ready ->
#     @i = 0
#     @myInt = setInterval ->
#       @i = @i + 1
#       $.get "step", (data) ->
#         $("#running-games").replaceWith data
#     , 2
#     return
#   $ ->
#     if @i == 100
#       clearInterval(@myInt)
#       alert "ola"
