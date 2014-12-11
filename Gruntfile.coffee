
module.exports = (grunt) ->
  grunt.initConfig
    cnfg:
      paths:
        node_modules: './node_modules/'
        bower_components: './bower_components/'
        public_js: './public/js/'
        public_css: './public/css/'
        public_fonts: './public/fonts/'
        src_coffee: 'source/coffee/'
        build_js: 'build/js/'
        build_css: 'build/js/'

    pkg: grunt.file.readJSON('package.json')
    assets: grunt.file.readJSON('assets.json')

    coffee:
      all:
        expand: true,
        cwd: '<%= cnfg.paths.src_coffee %>'
        src: ['**/*.coffee']
        dest: '<%= cnfg.paths.build_js %>'
        ext: '.js'

    concat:
      options:
        separator: ';'
      third:
        files: [
          '<%= assets.main.third %>',
          '<%= assets.main.third_min %>',
          '<%= assets.main.third_css %>',
          '<%= assets.main.third_css_min %>'
        ]
      vendor:
        src: ['build/js/**/*.js']
        dest: '<%= cnfg.paths.public_js %>vendor.js'

    copy:
      third_fonts:
        expand: true
        cwd: '<%= cnfg.paths.bower_components %>bootstrap/dist/fonts/'
        src: '*'
        dest: '<%= cnfg.paths.public_fonts %>'

      index:
        expand: true
        cwd: 'source'
        src: 'index.html'
        dest: 'public/'

    uglify:
      all:
        files:
          'public/js/vendor.min.js': 'public/js/vendor.js'

    shell:
      bower_install:
        command: 'bower install'

    clean:
      bower_components: ['<%= cnfg.paths.bower_components %>']
      build_js: ['<%= cnfg.paths.build_js %>']
      public_js: ['<%= cnfg.paths.public_js %>','<%= cnfg.paths.public_css %>']

    watch:
      html:
        files: ['source/index.html']
        tasks: ['copy:index']
      coffee:
        files: ['source/**/*.coffee']
        tasks: [
          'coffee:all',
          'uglify']
      sass:
        files: ['source/**/*.scss']
        tasks: ['sass']


  grunt.registerTask 'build', 'Build all code',
                     ['coffee:all',
                      'concat:vendor',
                      'uglify:all',
                      'concat:third']

  grunt.registerTask 'install', 'Install the package on an empty system',
                     ['shell:bower_install',
                      'build']




  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks('grunt-contrib-watch');