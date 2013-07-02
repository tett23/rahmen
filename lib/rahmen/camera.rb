module Rahmen
  class Camera
    def initialize(out_dir='./out')
      @out_dir = out_dir
    end
    attr_reader :out_dir

    def capture(out_path=nil)
      out_path = default_out_path if out_path.blank?

      capture = ::OpenCV::CvCapture.open
      mat = capture.query.to_CvMat
      mat.save(out_path)

      out_path
    end

    private
    def default_out_path(ext='jpg')
      FileUtils.mkdir_p(@out_dir) unless Dir.exists?(@out_dir)

      File.join(@out_dir, Digest::SHA1.hexdigest(Time.now.to_i.to_s+rand.to_s))+'.'+ext
    end
  end
end
