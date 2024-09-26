namespace ProtonPlus.Widgets {
    public class DescriptionDialog : Adw.Window {
        Models.Release release { get; set; }

        Adw.ToolbarView toolbar_view { get; set; }
        Adw.WindowTitle window_title { get; set; }
        Gtk.Button web_button { get; set; }
        Adw.HeaderBar header_bar { get; set; }
        Gtk.ScrolledWindow scrolled_window { get; set; }
        Gtk.Label description_label { get; set; }

        construct {
            window_title = new Adw.WindowTitle (_("More information"), "");

            web_button = new Gtk.Button.from_icon_name ("world-www-symbolic");
            web_button.set_tooltip_text (_("Open in a browser"));
            web_button.clicked.connect (web_button_clicked);

            header_bar = new Adw.HeaderBar ();
            header_bar.pack_start (web_button);
            header_bar.set_title_widget (window_title);

            description_label = new Gtk.Label (null);
            description_label.set_halign (Gtk.Align.START);

            scrolled_window = new Gtk.ScrolledWindow ();
            scrolled_window.set_child (description_label);
            scrolled_window.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
            scrolled_window.set_size_request (375, 175);
            scrolled_window.add_css_class ("card");
            scrolled_window.add_css_class ("dialog");
            scrolled_window.set_margin_top (7);
            scrolled_window.set_margin_bottom (12);
            scrolled_window.set_margin_start (12);
            scrolled_window.set_margin_end (12);

            toolbar_view = new Adw.ToolbarView ();
            toolbar_view.add_top_bar (header_bar);
            toolbar_view.set_content (scrolled_window);

            set_resizable (false);
            set_content (toolbar_view);
            set_transient_for (Application.window);
            set_modal (true);

            notify["release"].connect (release_changed);
        }

        public DescriptionDialog (Models.Release release) {
            this.release = release;
        }

        void release_changed () {
            window_title.set_subtitle (release.displayed_title);
            description_label.set_label (release.description);
        }

        void web_button_clicked () {
            Utils.System.open_url (release.page_url);
        }
    }
}