import {defineConfig} from 'vite';
import vue from '@vitejs/plugin-vue';
import eslint from '@rollup/plugin-eslint';
import path from 'path';

export default ({command, mode}) => {
  const config = {
    plugins: [
      eslint({
        include: /src\/*.+(vue|js|jsx|ts|tsx)/,
        exclude: [/vue&type=/, /node_modules/],
        throwOnError: true,
      }),
      vue(),
    ],
    resolve: {
      // extensions: ['.js', '.vue'],
      alias: {
        '@': path.join(process.cwd(), '/src'),
      },
    },
    server: {
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
