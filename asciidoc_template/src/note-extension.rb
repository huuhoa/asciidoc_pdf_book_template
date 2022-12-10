class AsciidoctorPdfExtensions < (Asciidoctor::Converter.for 'pdf')
  register_for 'pdf'

  def ink_chapter_title node, title, opts = {}
    if not (title.include? 'Chapter') # chapters
      super # delegate to default implementation
      return
    end
    part_number = title[/^Chapter (\d+)/, 1]
    title = title.sub(/^Chapter \d+\. /, '')
    layout_heading_customized title, part_number,
          box_height: 70,
          box_width: 130,
          background_color: '514AC1', 
          text_color: 'eeeeee',
          font_size: 60
    move_down 20
  end

  def ink_heading string, opts = {}
    hlevel = opts[:level]
    if hlevel != 3
      super # delegate to default implementation
      return
    end
    level = string[/(^\d+\.\d+)\./,1]
    heading = string.sub(/^\d+\.\d+\. /, '')
    layout_heading_customized heading, level,
          box_height: 40,
          box_width: 120,
          background_color: 'BB634D',
          text_color: 'eeeeee',
          font_size: 25
  end

  def layout_heading_customized heading_string, level_string, opts = {}
    box_height = opts[:box_height]
    box_width = opts[:box_width]
    background_color = opts[:background_color]
    text_color = opts[:text_color]
    font_size = opts[:font_size]

    current_cursor = cursor
    level_box_width = bounds.width + box_width - page_width
    level_left = page_width - box_width
    
    # NOTE: float ensures cursor position is restored and returns us to current page if we overrun
    float do
      bounding_box [level_left, current_cursor], width: box_width, height: box_height, position: 'left' do
        theme_fill_and_stroke_bounds 'heading', background_color: background_color
      end
      bounding_box [level_left, current_cursor], width: level_box_width, height: box_height, position: 'left' do
        font 'Heading' do
          # layout_heading level_string, align: :right, size: font_size, color: text_color, style: :normal, valign: :center
          text level_string, align: :right, size: font_size, color: text_color, style: :normal, valign: :center
        end
      end
    end
    heading_box_width = level_left - 10
    span(heading_box_width) do
    # bounding_box [0, current_cursor], width: heading_box_width do
      ink_prose heading_string, inline_format: true, margin_bottom: 0
    end
    move_down 20
  end
end

