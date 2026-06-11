# frozen_string_literal: true

module Knowledge
  CATEGORY_TITLES = {
    "ai" => "AI",
    "apple" => "Apple",
    "android" => "Android",
    "idea" => "Idea"
  }.freeze

  class PlainMarkdownPages < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      source_dirs(site).each do |dir|
        Dir.glob(site.in_source_dir(dir, "**", "*.md")).sort.each do |path|
          next if front_matter?(path)

          rel_path = Pathname.new(path).relative_path_from(Pathname.new(site.source)).to_s
          page_dir = File.dirname(rel_path)
          site.pages << PlainMarkdownPage.new(site, site.source, page_dir, File.basename(path))
        end
      end

      remove_static_markdown_files(site)
    end

    private

    def source_dirs(site)
      Array(site.config["knowledge_source_dirs"] || %w[ai apple android])
    end

    def front_matter?(path)
      File.open(path, "r", &:readline).strip == "---"
    rescue EOFError
      false
    end

    def remove_static_markdown_files(site)
      prefixes = source_dirs(site).map { |dir| "#{dir.sub(%r{/+\z}, "")}/" }
      site.static_files.reject! do |file|
        rel_path = file.relative_path.delete_prefix("/")
        file.extname == ".md" && prefixes.any? { |prefix| rel_path.start_with?(prefix) }
      end
    end
  end

  class PlainMarkdownPage < Jekyll::Page
    def read_yaml(base, name, _opts = {})
      path = site.in_source_dir(@dir, name)
      self.content = File.read(path)
      self.data = {
        "layout" => "default",
        "title" => title_from(content, name),
        "parent" => parent_title
      }
    end

    private

    def parent_title
      category = @dir.split("/").first.to_s
      CATEGORY_TITLES.fetch(category) do
        category.split("-").map(&:capitalize).join(" ")
      end
    end

    def title_from(content, name)
      heading = content.lines.find { |line| line.start_with?("# ") }
      return heading.delete_prefix("# ").strip if heading

      File.basename(name, ".md").split("-").map(&:capitalize).join(" ")
    end
  end
end
