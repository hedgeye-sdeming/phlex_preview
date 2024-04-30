require 'phlex'

class AppLayoutComponent < ApplicationComponent

  def app_styles
    style {
      unsafe_raw <<~CSS

body, html {
  font-family: 'Helvetica Neue', Arial, sans-serif;
  margin: 0;
  padding: 0;
  background: #f9f9f9;
  color: #333;
}

.container {
  width: 90%;
  margin: 0 auto;
  padding: 20px;
}

.textarea {
  width: 100%;
  height: 500px;
  margin-top: 10px;
  padding: 8px;
  box-sizing: border-box;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: none;
  background-color: #fff;
  font-family: 'Courier New', monospace;
}

button {
  padding: 10px 20px;
  margin-top: 10px;
  border: none;
  border-radius: 4px;
  background-color: #007BFF;
  color: white;
  cursor: pointer;
  font-size: 16px;
}

button:hover {
  background-color: #0056b3;
}

.section {
  background: white;
  border: 1px solid #ddd;
  padding: 15px;
  margin-top: 20px;
  border-radius: 4px;
}

h1 {
  color: #333;
  font-size: 24px;
}

.output-pane {
  background-color: #f4f4f4;
  border: 1px solid #ccc;
  padding: 10px;
  margin-top: 20px;
  overflow-x: auto;
  white-space: pre-wrap; /* Ensures that spaces and line breaks are respected */
}
textarea, iframe { width: 100%; height: 500px; margin-bottom: 20px; }
.params { height: 100px; margin-bottom: 20px; }
CSS
    }
  end
  def view_template
    html do
      head do
        title { "Phlex Preview App" }
        common_styles
        app_styles
      end

      body do
        div(class: "container") do 
        
          h1 {"Phlex Preview App"}
          div(class: "section") do

            form action: "/render", method: "post", target: "preview_frame" do
              label(for: 'code') { "Phlex Code:"}
              textarea name: "code", placeholder: "#Type your Phlex component code here...\nclass YourComponent < Phlex::HTML\n  ..."
              
              label(for: 'params') {"How to invoke your component(include necessary params):"}
              textarea(class: 'params', name: "params", placeholder: "e.g., UserProfileComponent(User.new(name: 'John Doe'))")
              
              button( type: "submit") { "Render"}
            end
          end

          div(class: 'section output-pane') do
            h2 {"Preview:"}
            iframe name: "preview_frame", srcdoc: "Your rendered output will appear here..."
          end
        end
      end
    end
  end
end
