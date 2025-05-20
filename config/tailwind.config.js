/** @type {import('tailwindcss').Config} */

module.exports = {
  content: [
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/components/**/*.{erb,haml,html,slim,rb}'
  ],
  theme: {
    extend: {
      colors: {
        background: {
          DEFAULT: '#0D1117', // Un gris muy oscuro, casi negro (como el fondo de GitHub)
          surface: '#161B22', // Un gris ligeramente más claro para superficies elevadas
          card: '#1E242C',    // Para tarjetas o secciones
          100: '#0B0F1A', // fondo principal
          200: '#121826', // superficie suave
          300: '#1C2433'
        },
        text: {
          DEFAULT: '#C9D1D9', // Texto principal, un gris claro para contraste
          secondary: '#8B949E',// Texto secundario o menos importante
          muted: '#586069',    // Texto aún más apagado
          link: '#58A6FF',     // Color para enlaces, un azul brillante
          100: '#FFFFFF',
          200: '#E4E8F3',
          300: '#A0A8C0'
        },
        // Paleta semántica inspirada en las imágenes
        primary: { // Principalmente tonos azules brillantes para acciones y elementos destacados
          DEFAULT: '#2F81F7', // Azul brillante principal
          100: '#DDF4FF',
          200: '#B6E3FF',
          300: '#8ED2FF',
          400: '#58A6FF', // Similar al color de enlace, bueno para botones primarios
          500: '#2F81F7', // Tono principal
          600: '#1F6FEB',
          700: '#165FC1',
          800: '#104797',
          900: '#0B3470',
          hover: '#1F6FEB', // Para el hover de elementos primarios
        },
        secondary: { // Podríamos usar un verde o un púrpura sutil de las imágenes
          DEFAULT: '#3FB950', // Verde para éxito o información secundaria positiva
          100: '#D1F7C4',
          200: '#A8EDB4',
          300: '#7FDE93',
          400: '#56CF73',
          500: '#3FB950', // Tono principal
          600: '#2C9B4D',
          700: '#1E7B42',
          800: '#135C35',
          900: '#0A3D28',
          hover: '#2C9B4D',
        },
        accent: { // Para elementos que necesitan llamar mucho la atención, como alertas o notificaciones
          DEFAULT: '#F7782F', // Naranja vibrante
          100: '#FFEEDA',
          200: '#FFD6B5',
          300: '#FFBE90',
          400: '#FFA76A',
          500: '#F7782F', // Tono principal
          600: '#DB5F20',
          700: '#B34B1B',
          800: '#8C3A15',
          900: '#6F2D11',
          hover: '#DB5F20',
        },
         success: {
          400: '#22C55E',
        },
        danger: { // Para errores o acciones destructivas
          DEFAULT: '#DA3633', // Rojo
          100: '#FFDEDE',
          200: '#FFB9B9',
          300: '#FF9494',
          400: '#F86A6A',
          500: '#DA3633', // Tono principal
          600: '#B72424',
          700: '#941A1A',
          800: '#721212',
          900: '#570D0D',
          hover: '#B72424',
        },
        warning: { // Para advertencias
          DEFAULT: '#EBB32A', // Amarillo/Naranja
          100: '#FFF8DD',
          200: '#FFF0B8',
          300: '#FFE793',
          400: '#FFDD6E',
          500: '#EBB32A', // Tono principal
          600: '#CEA021',
          700: '#AC861B',
          800: '#886B14',
          900: '#6A540F',
          hover: '#CEA021',
        },
        info: { // Para información neutral
          DEFAULT: '#58A6FF', // Podríamos reusar el azul de 'link' o 'primary'
          100: '#DDF4FF',
          200: '#B6E3FF',
          300: '#8ED2FF',
          400: '#58A6FF',
          500: '#2F81F7',
          600: '#1F6FEB',
          700: '#165FC1',
          800: '#104797',
          900: '#0B3470',
          hover: '#1F6FEB',
        },
      },
      fontFamily: {
        sans: [
          'Inter',
          'ui-sans-serif',
          'system-ui',
          '-apple-system',
          'BlinkMacSystemFont',
          '"Segoe UI"',
          'Roboto',
          '"Helvetica Neue"',
          'Arial',
          '"Noto Sans"',
          'sans-serif',
          '"Apple Color Emoji"',
          '"Segoe UI Emoji"',
          '"Segoe UI Symbol"',
          '"Noto Color Emoji"',
        ],
      },
    },
  },
  plugins: [
  ],
}
