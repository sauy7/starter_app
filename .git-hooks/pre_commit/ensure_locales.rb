# frozen_string_literal: true

require 'i18n'
require_relative '../../config/initializers/i18n'

module Overcommit
  module Hook
    module PreCommit
      class EnsureLocales < Base
        include I18n

        attr_reader :errors, :alt_lang, :out

        def run
          @errors ||= []
          @out ||= { 'en' => [] }
          process_languages
          return :fail, errors.join("\n") if errors.any?
          :pass
        end

        private

        def add_en_error
          errors << "\e[31mFound in #{alt_lang}, missing from en:\e[0m"
          errors << out['en'].join("\n")
        end

        def add_errors
          add_other_error unless no_other
          add_en_error unless no_en
        end

        def add_other_error
          errors << "\e[31mMissing from #{alt_lang}:\e[0m"
          errors << out[alt_lang].join("\n")
        end

        def alt_file(file)
          file_name = file.gsub('en.yml', "#{alt_lang}.yml")
          YAML.load_file(file_name)[alt_lang]
        rescue
          errors << "\e[31mMissing file:\e[0m"
          errors << file_name
          nil
        end

        def diff(root, compared, structure = [], out = [])
          root.each_key do |key|
            compared_key = compared[key]
            next_root = root[key]
            new_structure = structure.dup << key
            next_compared = compared.fetch(key, nil)
            out << new_structure.join('.') if compared.nil? || compared_key.nil?
            next unless next_root.is_a? Hash
            diff(next_root, next_compared, new_structure, out)
          end
        end

        def diff_file(file)
          english = YAML.load_file(file)['en']
          translation_file = alt_file(file)
          return unless translation_file
          diff(english, translation_file, [alt_lang], out[alt_lang])
          diff(translation_file, english, ['en'], out['en'])
        end

        def diff_files(lang)
          @alt_lang = lang.to_s
          out[alt_lang] = []
          applicable_files.each { |file| diff_file(file) }
        end

        def no_en
          out['en'].empty?
        end

        def no_errors
          no_other && no_en
        end

        def no_other
          out[alt_lang].empty?
        end

        def process_languages
          I18n.available_locales.delete_if { |key| key == :en }.each do |lang|
            diff_files(lang)
            next if no_errors
            add_errors
          end
        end
      end
    end
  end
end
