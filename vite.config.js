import {defineConfig} from 'vite';
import vue from '@vitejs/plugin-vue';
import eslint from '@vpsvl/vite-plugin-eslint';
import stylelint from 'vite-plugin-stylelint';
import path from 'path';

const INVALID_CHAR_START_REGEX = /^[\x00-\x1F\x7F<>*#"{}|^[\]`;?:&=+$,]/;
const INVALID_CHAR_REGEX = /[\x00-\x1F\x7F<>*#"{}|^[\]`;?:&=+$,]/g;
const DRIVE_LETTER_REGEX = /^[a-z]:/i;
export default defineConfig(({command}) => {
  const config = {
    plugins: [
      eslint(),
      stylelint({
        customSyntax: 'postcss-less',
        include: /src\/.*\.(vue|less|s?css)$/,
        exclude: [/vue&type=/, /node_modules/],
        cache: false,
      }),
      vue(),
    ],
    resolve: {
      extensions: ['.js', '.vue'],
      alias: {
        '@': path.join(process.cwd(), '/src'),
      },
    },
    define: {
      __VUE_PROD_HYDRATION_MISMATCH_DETAILS__: false,
      __VUE_OPTIONS_API__: true,
      __VUE_PROD_DEVTOOLS__: false,
    },
    server: {
      host: true,
      port: 4000,
    },
    build: {
      outDir: 'docs',
      rollupOptions: {
        output: {
          sanitizeFileName(name) {
            const match = DRIVE_LETTER_REGEX.exec(name);
            const driveLetter = match ? match[0] : '';
            return (
              driveLetter +
              name
                .slice(driveLetter.length)
                .replace(INVALID_CHAR_START_REGEX, '')
                .replace(INVALID_CHAR_REGEX, '-')
            );
          },
        },
      },
    },
  };
  if (command === 'build') {
    config.base = '/jsqxz/';
  }
  return config;
});
