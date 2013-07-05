module Rahmen
  class Image
    def initialize(image_path)
      raise 'file not exist' unless File.exists?(image_path)

      @image_path = image_path
      @mat = ::OpenCV::CvMat.load(@image_path, ::OpenCV::CV_LOAD_IMAGE_ANYCOLOR | ::OpenCV::CV_LOAD_IMAGE_ANYDEPTH)
    end
    attr_reader :image_path

    def feature_point
      gray = self.to_gray
      keypoints, = gray.extract_surf(::OpenCV::CvSURFParams.new(500, true, 2, 3))

      keypoints.each do |keypoint|
        next unless keypoint.size > 25
        text = "#{keypoint.laplacian}, #{keypoint.size}"
        @mat.put_text!(text, keypoint.pt, ::OpenCV::CvFont.new(:simplex, hscale: 0.3, vscale: 0.3), ::OpenCV::CvColor::Blue)
        @mat.circle!(keypoint.pt, (keypoint.size*0.25), color: ::OpenCV::CvColor::Blue, thickness: 1, line_type: :aa)
      end

      ::OpenCV::GUI::Window.new('SURF').show @mat
      ::OpenCV::GUI::wait_key
    end

    def to_gray
      @mat.RGB2GRAY
    end
  end
end
