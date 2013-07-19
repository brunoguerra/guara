var I18n = I18n || { defaultLocale: "pt-BR", locale: 'pt-BR' };
I18n.translations = I18n.translations || { "pt-BR": {} };

I18n.translations["pt-BR"] = {
  'waiting': 'Aguarde...',
  'back': 'Voltar',

};

I18n.t = function(id) {
  var l = I18n.locale || I18n.defaultLocale;
  return I18n.translations[l][id];
};


I18n.merge = function(locale,translations){
    I18n.translations[locale] = this.translations[locale] || {};
    for (var attrname in translations) { I18n.translations[locale][attrname] = translations[attrname]; }
}