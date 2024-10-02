import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import StimulusPlugin from 'vite-plugin-stimulus-hmr'
import FullReload from 'vite-plugin-full-reload'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    StimulusPlugin(),
    FullReload(['config/routes.rb', 'app/views/**/*'], { delay: 200 })
  ],
})