# frozen_string_literal: true

if Rails.env.development?
  require 'rubycritic/rake_task'
  require 'yaml'
  require 'bundler/audit/task'

  Bundler::Audit::Task.new

  namespace :development do
    task :brakeman do
      cmd = 'brakeman -q -z -c config/brakeman.ignore -o tmp/brakeman.html'
      exit_code = system(cmd)
      if exit_code
        print "\e[32mBrakeman OK\e[0m\n"
      else
        print "\e[31mBrakeman errors\e[0m\n"
        abort 'Brakeman errors'
      end
    end

    desc 'Diff locale files'
    task locale_diff: :environment do
      def diff(root, compared, structure = [], out = [])
        root.each_key do |key|
          next_root     = root[key]
          next_compared = compared.nil? ? nil : compared[key]
          new_structure = structure.dup << key
          out << new_structure.join('.') if compared.nil? || compared[key].nil?
          if next_root.is_a? Hash
            diff(next_root, next_compared, new_structure, out)
          end
        end
      end

      files = Dir[Rails.root.join('config', 'locales', '*en.yml')] +
        Dir[Rails.root.join('app', 'views', 'components', '**', '*en.yml')]

      I18n.available_locales.delete_if { |l| l == :en }.each do |l2|
        l2 = l2.to_s
        out = { 'en' => [], l2 => [] }

        files.each do |file|
          first = YAML.load_file(file)
          alt_file = file.gsub('en.yml', "#{l2}.yml")
          second = YAML.load_file(alt_file)
          diff(first['en'], second[l2], [l2], out[l2])
          diff(second[l2], first['en'], ['en'], out['en'])
        end
        if out[l2].empty? && out['en'].empty?
          puts "\e[32mLocale keys OK\e[0m\n"
        else
          unless out[l2].empty?
            puts "\e[31mMissing from #{l2}:\e[0m"
            puts out[l2].join("\n")
          end
          unless out['en'].empty?
            puts "\e[31mFound in #{l2}, missing from en:\e[0m"
            puts out['en'].join("\n")
          end
          abort "\e[31mLocale keys missing\e[0m"
        end
      end
    end

    task :rails_best_practices do
      path = File.expand_path('../../../', __FILE__)
      cmd = 'rails_best_practices -f html ' \
            "--output-file=tmp/rails_best_practices.html #{path}"
      exit_code = system(cmd)
      if exit_code
        print "\e[32mBest practices OK\e[0m\n"
      else
        print "\e[31mViolating best practices\e[0m\n"
        abort 'Violating best practices'
      end
    end

    task :rubocop do
      exit_code = system('rubocop -f simple -o tmp/rubocop.txt')
      if exit_code
        print "\e[32mRubocop OK\e[0m\n"
      else
        abort "\e[31mRubocop offences reported\e[0m\n"
      end
    end
  end

  RubyCritic::RakeTask.new do |task|
    task.paths = FileList['app/**/*.rb']
    task.options = '--no-browser'
  end

  desc 'Run all development tools'
  task check: %w[development:locale_diff development:rubocop
                 development:brakeman development:rails_best_practices
                 rubycritic bundle:audit]
end
