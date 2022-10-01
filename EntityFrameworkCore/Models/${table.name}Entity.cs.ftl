<#-- @ftlvariable name="table" type="bbd.jportal2.Table" -->
<#import "basefunctions.ftl" as base>
// ########################################################################################################################
// ################## Generated Code. DO NOT CHANGE THIS CODE. Change it in the generator and regenerate ##################
// ########################################################################################################################
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ${database.packageName}.EntityFrameworkCore.Models
{
    public class ${table.name}Entity
    {
        public static string Scheme = "${database.getSchema()}";

        <#list table.fields as field>
<#if field.isNull()>
#nullable enable
</#if>
        <#if field.isPrimaryKey()>
        [Key]
            <#if field.type?c == '10' || field.type?c == '14' || field.type?c == '24' || field.type?c == '25'>
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
            <#else>
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
            </#if>
        </#if>
        <#if base.getEFColumnType(field) == 'string'>
        [StringLength(${field.length?c})]
        </#if>
        public <#compress>${base.getEFColumnType(field)}<#if field.isNull()>?</#if></#compress> ${field.name} { get; set; }<#if field.type?c = '18'> = DateTime.UtcNow; </#if>
<#if field.isNull()>
#nullable disable
</#if>
        </#list>
        <#list table.links as link>
        [ForeignKey(nameof(${link.fields[0]}))]
        public <#compress>${link.getName()}Entity ${link.getName()}</#compress> { get; set; }
        </#list>
    }
    <#list table.procs as proc>
    <#if !proc.isStdExtended() && !proc.isSProc() && proc.name != "">
        <#if proc.lines?size gt 0 && proc.outputs?size gt 0>
    public class ${table.name}Entity${proc.name}
    {
        <#list proc.outputs as field>
<#if field.isNull()>
#nullable enable
</#if>
        public <#compress>${base.getEFColumnType(field)}<#if field.isNull()>?</#if></#compress> ${field.name} { get; set; }
<#if field.isNull()>
#nullable disable
</#if>
        </#list>
    }
        </#if>
    </#if>
    </#list>
}