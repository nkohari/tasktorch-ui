remapify = require 'remapify'

expose = (module) ->
  {expose: module, cwd: "#{__dirname}/src/#{module}", src: '**/*.coffee'}

module.exports = (grunt) ->

  grunt.loadNpmTasks('grunt-browserify')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-stylus')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-notify')

  grunt.initConfig

    browserify:
      app:
        options:
          alias: ['react:react']
          browserifyOptions: {extensions: ['.coffee']}
          transform: ['coffeeify']
          preBundleCB: (bundle) ->
            bundle.plugin(remapify, [
              expose('common')
              expose('events')
              expose('framework')
              expose('mixins')
              expose('requests')
            ])
        files:
          'dist/torch.js': ['src/**/*.coffee']

    clean:
      app: ['dist']

    stylus:
      app:
        options:
          paths: ['style/imports']
          import: ['nib', 'variables']
        files:
          'dist/torch.css': ['style/**/!(imports)/*.styl']

    copy:
      app:
        files: [{expand: true, cwd: 'assets', src: ['**'], dest: 'dist'}]

    notify:
      browserify:
        options:
          title: 'Grunt'
          message: 'JS build complete'
      stylus:
        options:
          title: 'Grunt'
          message: 'CSS build complete'

    watch:
      code:
        files: ['src/**/*.coffee']
        tasks: ['browserify:app', 'notify:browserify']
        options: {spawn: false}
      style:
        files: ['style/**/*.styl']
        tasks: ['stylus:app', 'notify:stylus']
        options: {spawn: false}

  grunt.registerTask 'build', ['browserify', 'stylus', 'copy']
  grunt.registerTask 'default', ['build']
