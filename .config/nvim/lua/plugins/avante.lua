return {
  "yetone/avante.nvim",
  opts = {
    provider = "ollama",
    vendors = {
      ---@type AvanteProvider
      ollama = {
        api_key_name = "",
        ask = "",
        endpoint = "http://127.0.0.1:11434/api",
        model = "deepseek-r1:14b",
        -- model = "qwen2.5-coder:14b",
        -- model = "llama3.1:latest",
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint .. "/chat",
            headers = {
              ["Accept"] = "application/json",
              ["Content-Type"] = "application/json",
            },
            body = {
              model = opts.model,
              options = {
                num_ctx = 131072,
              },
              messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
              stream = true,
            },
          }
        end,
        parse_stream_data = function(data, handler_opts)
          -- Parse the JSON data
          local json_data = vim.fn.json_decode(data)
          -- Check for stream completion marker first
          if json_data and json_data.done then
            handler_opts.on_complete(nil) -- Properly terminate the stream
            return
          end
          -- Process normal message content
          if json_data and json_data.message and json_data.message.content then
            -- Extract the content from the message
            local content = json_data.message.content
            -- Call the handler with the content
            handler_opts.on_chunk(content)
          end
        end,
      },
    },
  },
}
