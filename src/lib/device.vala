namespace devident {
  /**
   * Base device class
   */
  public abstract class Device : GLib.Object {
    public abstract string get_id() throws GLib.Error;
    public abstract string get_name() throws GLib.Error;
    public abstract string get_manufacturer() throws GLib.Error;

    [DBus(visible = true, name = "get_components")]
    public abstract GLib.ObjectPath[] get_components_dbus() throws GLib.Error;

    [DBus(visible = false)]
    public abstract Component[] get_components();

    /**
     * Get all components for a given category
     */
    public Component[] get_all_for_category(ComponentCategory cat) throws GLib.Error {
      var components = this.get_components();

      var num_found = 0;
      for (var i = 0; i < components.length; i++) {
        var comp = components[i];
        if (comp.get_category() == cat) num_found++;
      }

      Component[] found = new Component[num_found];

      var x = 0;
      for (var i = 0; i < components.length; i++) {
        var comp = components[i];
        if (comp.get_category() == cat) found[x++] = comp;
      }
      return found;
    }

    /**
     * Get all present components
     */
    public Component[] get_present_components() throws GLib.Error {
      var components = this.get_components();

      var num_present = 0;
      for (var i = 0; i < components.length; i++) {
        var comp = components[i];
        if (comp.is_present()) num_present++;
      }

      Component[] present = new Component[num_present];

      var x = 0;
      for (var i = 0; i < components.length; i++) {
        var comp = components[i];
        if (comp.is_present()) present[x++] = comp;
      }
      return present;
    }
  }
}