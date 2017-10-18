#
# The value goes as, the <file_name>//<xpath>,<true/false>
# where <file_name> - is the file (along with the file path) to be secured,
#       <xpath> - is the xpath to the property value to be secured
#       <true / false> - This is true if the last parameter in the xpath is parameter (starts with [ and ends with ])
# and you want its value to be replaced with "password"
 
<% secure_vault_configs.each{secure_vault_config_name, secure_vault_config-> %>
<%= secure_vault_config['secret_alias'] %>=[<%= secure_vault_config['secret_alias_value'] %>]
<% } %>
