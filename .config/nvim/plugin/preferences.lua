-- Clipboard
--
vim.opt.clipboard:append("unnamedplus")
-- Usa el portapapeles del sistema (registro +) como portapapeles predeterminado

-- UI
--
vim.o.confirm = true
-- Permite confirmar guardado de cambios antes de cerrar archivos modificados

vim.o.cursorline = true
-- Resalta la línea actual del cursor

vim.opt.cursorlineopt = { "number" }
-- Solo resalta el número de línea en lugar de toda la línea

vim.o.modeline = false
vim.o.modelines = 0
-- Desactiva el uso de modelines (por seguridad)

-- Edit
--
vim.o.tabstop = 2
--
vim.o.expandtab = true
-- Convierte tabs en espacios

vim.o.softtabstop = -1
-- Usa el valor de shiftwidth cuando presionas Tab en modo insert

vim.o.shiftwidth = 0
-- Usa el valor de 'tabstop' como ancho de sangrado

vim.o.shiftround = true
-- Ajusta el indentado al múltiplo más cercano de 'shiftwidth'

vim.o.virtualedit = "all"
-- Permite mover el cursor a posiciones "vacías", útil en visual block

-- Splits
--
vim.o.splitright = true
-- Las ventanas verticales nuevas se abren a la derecha

vim.o.splitbelow = true
-- Las ventanas horizontales nuevas se abren abajo

vim.o.equalalways = true
-- Siempre iguala el tamaño de ventanas al hacer splits

vim.o.splitkeep = "screen"
-- Mantiene la pantalla estable al dividir ventanas

-- Scroll
--
vim.o.scrolloff = 30
-- Mínimo de 30 líneas por encima y debajo del cursor

vim.o.sidescrolloff = 30
-- Mínimo de 30 columnas a la izquierda y derecha del cursor

vim.o.cmdwinheight = 30
-- Altura de la ventana de comandos (:q, etc.)

vim.o.colorcolumn = "+0"
-- Muestra una columna guía en la posición de 'textwidth' (si está definido)

vim.o.list = true
-- Muestra caracteres invisibles

vim.opt.listchars = {
  nbsp = "␣", -- Espacio no separable
  tab = "  ", -- Representación visual del tab
  trail = "·", -- Espacios al final de la línea
}

-- Status lines
--
vim.o.laststatus = 3
-- Muestra una sola línea de estado global

vim.o.showtabline = 1
-- Muestra la línea de pestañas solo si hay varias pestañas

vim.o.showmode = false
-- Oculta mensajes como "-- INSERT --" (útil si usas una barra de estado personalizada)

vim.o.showcmd = false
-- No muestra comandos parcialmente escritos en la parte inferior

vim.o.inccommand = "split"
-- Muestra resultado de sustituciones (`:s///`) en tiempo real en una ventana dividida

-- Lines
--

vim.o.number = true
-- Muestra número de línea absoluto

vim.o.relativenumber = true
-- Muestra números relativos (útil para navegar con movimientos como `5j`)

vim.o.numberwidth = 3
-- Ancho mínimo de la columna de números

-- Break lines
--

vim.o.linebreak = true
-- Rompe líneas solo en espacios para no cortar palabras

vim.o.breakindent = true
-- Mantiene indentado el texto envuelto

vim.o.breakindentopt = "list:-1"
-- Ajusta el comportamiento de indentado de líneas largas

-- Cursor
vim.opt.guicursor = {
  "n-sm:block", -- Bloque en modo normal y select
  "v:hor50", -- Cursor horizontal al 50% en modo visual
  "c-ci-cr-i-ve:ver10", -- Cursor vertical delgado en insert, command, replace, etc.
  "o-r:hor10", -- Cursor horizontal delgado en modo operator y replace
  "a:Cursor/Cursor-blinkwait1-blinkon1-blinkoff1", -- Parpadeo personalizado para todos los modos
}
