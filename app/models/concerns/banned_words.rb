module BannedWords
  extend ActiveSupport::Concern

  def banned_urls(url)
    if reserved.include? url
      true
    elsif banned.include? url
      true
    end
  end

  def reserved
    %w(
      www
      admin
      cpanel
      mail
      email
      http
      https
      whm
      root
      main
      app
      lrs
    )
  end

  def banned
    %w(
      anal
      anus
      arse
      ass
      ballsack
      balls
      bastard
      bitch
      biatch
      bloody
      blowjob
      blow job
      bollock
      bollok
      boner
      boob
      bugger
      bum
      butt
      buttplug
      clitoris
      cock
      coon
      crap
      cunt
      damn
      dick
      dildo
      dyke
      fag
      feck
      fellate
      fellatio
      felching
      fuck
      fudgepacker
      flange
      goddamn
      hell
      homo
      jerk
      jizz
      knobend
      labia
      lmao
      lmfao
      muff
      nigger
      nigga
      omg
      penis
      piss
      poop
      prick
      pube
      pussy
      queer
      scrotum
      sex
      shit
      sh1t
      slut
      smegma
      spunk
      tit
      tosser
      turd
      twat
      vagina
      wank
      whore
      wtf
    )
  end
end
