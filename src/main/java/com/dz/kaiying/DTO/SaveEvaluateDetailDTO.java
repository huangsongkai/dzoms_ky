package com.dz.kaiying.DTO;
// default package

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
public class SaveEvaluateDetailDTO implements java.io.Serializable {

	/**
	 *保存绩效考核详细内容
	 */
	private String inputs;
	private Double score;
	private String complete;
	private String remarks;

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getComplete() {
		return complete;
	}

	public void setComplete(String complete) {
		this.complete = complete;
	}

	public String getInputs() {
		return inputs;
	}

	public void setInputs(String inputs) {
		this.inputs = inputs;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

    /**
     * Created by huang on 2018/2/26.
     */

    public static class JobStatisticsYearDTO {
         class KpScore{
            Double total;
            Double bengang;
            String peishu;
        }
        class PlusOrMinusPoints{
            String rcgz;
            String xwgf;
        }
        String name;
        String department;
        KpScore kpScore;
        PlusOrMinusPoints plusOrMinusPoints;
        String remarks;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getDepartment() {
            return department;
        }

        public void setDepartment(String department) {
            this.department = department;
        }

        public KpScore getKpScore() {
            return kpScore;
        }

        public void setKpScore(KpScore kpScore) {
            this.kpScore = kpScore;
        }

        public PlusOrMinusPoints getPlusOrMinusPoints() {
            return plusOrMinusPoints;
        }

        public void setPlusOrMinusPoints(PlusOrMinusPoints plusOrMinusPoints) {
            this.plusOrMinusPoints = plusOrMinusPoints;
        }

        public String getRemarks() {
            return remarks;
        }

        public void setRemarks(String remarks) {
            this.remarks = remarks;
        }
    }
}