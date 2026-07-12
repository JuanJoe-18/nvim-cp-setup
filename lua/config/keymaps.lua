-- =====================================================================
-- SIR ALGORITMICSON: COMPILADOR CP (RUTAS BLINDADAS + PAUSA INTERACTIVA)
-- =====================================================================
local function compile_and_run_cp()
  -- 1. Guardar el archivo actual silenciosamente
  vim.cmd("silent! write")

  -- 2. Extraer rutas de forma segura
  local file_name = vim.fn.expand("%:t")      -- Ejemplo: testcode.cpp
  local bin_name  = vim.fn.expand("%:t:r")    -- Ejemplo: testcode
  local dir_path  = vim.fn.expand("%:p:h")    -- Directorio exacto

  -- 3. Comando Maestro:
  -- Compila con g++ -> Si tiene éxito (&&), ejecuta el binario.
  -- Sin importar qué pase (;), imprime un aviso y espera a que presiones Enter (read).
  local cmd = string.format(
    "g++ -O3 -Wall -Wextra -std=c++17 %s -o %s && ./%s ; echo '' ; echo '--- Proceso terminado (Presiona Enter para cerrar) ---' ; read",
    file_name, bin_name, bin_name
  )

  -- 4. Ejecutar en terminal flotante dentro de la carpeta del archivo
  Snacks.terminal(cmd, { 
    interactive = true,
    cwd = dir_path 
  })
end

vim.keymap.set("n", "<F5>", compile_and_run_cp, { desc = "[CP] Compilar y Ejecutar (F5)" })
vim.keymap.set("n", "<leader>r", compile_and_run_cp, { desc = "[CP] Compilar y Ejecutar (<leader>r)" })
