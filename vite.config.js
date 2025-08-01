import {defineConfig} from 'vite';
import vue from '@vitejs/plugin-vue';
import eslint from '@vpsvl/vite-plugin-eslint';
import stylelint from 'vite-plugin-stylelint';
import path from 'path';

export default ({command}) => {
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
      'import.meta.env.BASE': JSON.stringify('/jsqxz/'),
    },
    server: {
      host: true,
      port: 4000,
    },
    build: {
      outDir: 'docs',
    },
  };
  if (command === 'build') {
    config.base = '/jsqxz/';
  }
  return defineConfig(config);
};
