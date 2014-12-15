
module.exports = (grunt) ->
  grunt.initConfig
    cnfg:
      paths:
        node_modules: './node_modules/'
        bower_components: './bower_components/'
        sas_cache: '.sass-cache'
        npm_log: 'npm-debug.log'

        src: './source/'
        src_coffee: './source/coffee/'
        src_sass: './source/sass/'
        src_templates: './source/templates/'

        build: './build/'
        build_js: './build/js/'
        build_css: './build/css/'

        public: './public/'
        public_js: './public/js/'
        public_css: './public/css/'
        public_fonts: './public/fonts/'
        public_templates: './public/templates/'

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
        separator: ' '

      third:
        files: [
          '<%= assets.main.third %>',
          '<%= assets.main.third_min %>',
          '<%= assets.main.third_css %>',
          '<%= assets.main.third_css_min %>'
        ]

      main_js:
        src: ['<%= cnfg.paths.build_js %>main.js',
              '<%= cnfg.paths.build_js %>**/*.js']
        dest: '<%= cnfg.paths.public_js %>main.js'

      main_css:
        src: ['<%= cnfg.paths.build_css %>**/*.css']
        dest: '<%= cnfg.paths.public_css %>main.css'

    compass:
      dist:
        options:
          sassDir: '<%= cnfg.paths.src_sass %>'
          cssDir: '<%= cnfg.paths.build_css %>'

    cssmin:
      main:
        files:[
          '<%= cnfg.paths.public_css %>main.min.css':
            '<%= cnfg.paths.public_css %>main.css'
        ]

    copy:
      third_fonts:
        expand: true
        cwd: '<%= cnfg.paths.bower_components %>bootstrap/dist/fonts/'
        src: '*'
        dest: '<%= cnfg.paths.public_fonts %>'

      index:
        expand: true
        cwd: '<%= cnfg.paths.src %>'
        src: 'index.html'
        dest: '<%= cnfg.paths.public %>'

      html:
        expand: true
        cwd: '<%= cnfg.paths.src %>'
        src: '**/*.html'
        dest: '<%= cnfg.paths.public %>'

      templates:
        expand: true
        cwd: '<%= cnfg.paths.src_templates %>'
        src: '*'
        dest: '<%= cnfg.paths.public_templates %>'

    uglify:
      main:
        files:
          '<%= cnfg.paths.public_js %>main.min.js':
            '<%= cnfg.paths.public_js %>main.js'

    clean:
      bower_components: ['<%= cnfg.paths.bower_components %>']
      build: ['<%= cnfg.paths.build %>']
      public: ['<%= cnfg.paths.public %>']
      sass_cache: ['<%= cnfg.paths.sas_cache %>']
      npm_log: '<%= cnfg.paths.npm_log %>'

    shell:
      bower_install:
        command: 'bower install'

    watch:

      html:
        files: ['<%= cnfg.paths.src %>**/*.html']
        tasks: ['newer:copy:html']

      coffee:
        files: ['<%= cnfg.paths.src %>**/*.coffee']
        tasks: ['coffee',
                'concat:main_js',
                'uglify']
      sass:
        files: ['<%= cnfg.paths.src %>**/*.sass']
        tasks: ['compass',
                'concat:main_css',
                'cssmin']


  grunt.registerTask 'build', 'Build all code',
                     ['coffee',
                      'compass',
                      'copy',
                      'concat',
                      'uglify',
                      'cssmin']

  grunt.registerTask 'install', 'Install the package on an empty system',
                     ['shell:bower_install',
                      'build']




  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-newer'