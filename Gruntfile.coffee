module.exports = (grunt) ->

  grunt.loadNpmTasks('grunt-browserify')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-compress')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-stylus')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-notify')

  grunt.initConfig

    browserify:
      all:
        options:
          alias: ['react:react']
          browserifyOptions: {extensions: ['.coffee']}
          transform: ['coffeeify']
          watch: true
        files:
          '.build/js/torch.js': ['src/**/*.coffee']

    compress:
      prod:
        options:
          mode: 'tgz'
          archive: 'dist/package.tar.gz'
        files: [{expand: true, cwd: '.out', src: ['**']}]

    clean:
      temp: ['.out']
      dist: ['dist']

    stylus:
      all:
        options:
          paths: ['style/imports']
          import: ['nib', 'functions', 'variables']
        files:
          '.build/css/torch.css': ['style/base.styl', 'style/**/!(imports)/*.styl']

    copy:
      dev:
        files: [{expand: true, cwd: 'assets', src: ['**'], dest: '.build'}]
      prod:
        files: [
          {expand: true, cwd: 'assets', src: ['**'], dest: '.out'}
          {src: '.build/css/torch.css', dest: '.out/css/torch.css'}
        ]

    notify:
      browserify:
        options:
          title: 'Grunt'
          message: 'JS build complete'
      stylus:
        options:
          title: 'Grunt'
          message: 'CSS build complete'

    uglify:
      prod:
        files:
          '.out/js/torch.js': ['.build/js/torch.js']

    watch:
      style:
        files: ['style/**/*.styl']
        tasks: ['stylus', 'notify:stylus']
        options: {spawn: false}

  grunt.registerTask 'build',   ['browserify', 'stylus', 'uglify', 'copy:prod', 'compress:prod', 'clean:temp']
  grunt.registerTask 'dev',     ['browserify', 'stylus', 'copy:dev', 'watch']
  grunt.registerTask 'default', ['build']
