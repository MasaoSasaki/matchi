module ApplicationHelper

  def default_meta_tags
    {
      site: 'Matchi(マッチ)',
      title: 'TOP',
      reverse: true,
      separator: '|',
      description: 'あなたの街の飲食店を、あなたの信頼でお得に予約する。',
      keywords: 'レストラン 予約, レストラン キャンセル, 予約 キャンセル, 飲食店 キャンセル',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('home-icon.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
        { href: image_url('home-icon.png'), rel: 'android-touch-icon', sizes: '192x192', type: 'image/jpg' },
      ],
      og: {
        site_name: 'Matchi(マッチ)',
        title: 'TOP',
        description: 'あなたの街の飲食店を、あなたの信頼でお得に予約する。',
        type: 'website',
        url: request.original_url,
        image: image_url('eye_catch.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@Masao_Sasaki_ae',
      },
      fb: {
        app_id: '100011080352632'
      }
    }
  end

end
