module.exports = {
  entry: "./widgets.jsx",
  output: {
      filename: "bundle.js"
  },
  module: {
   loaders: [
     {
       test: [/\.jsx?$/],
       exclude: /(node_modules)/,
       loader: 'babel-loader',
       query: {
         presets: ['es2015', 'react']
       }
     }
   ]
  },
  devtool: 'source-map',
  resolve: {
    extensions: ['.js','.jsx','*']
  },
};
