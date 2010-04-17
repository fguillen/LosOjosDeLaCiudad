Paperclip.options[:command_path] = APP_CONFIG[:paperclip_identify_path]
Paperclip.options[:swallow_stderr] = false

Paperclip.interpolates :camera_id do |attachment, style|
  attachment.instance.camera_id
end